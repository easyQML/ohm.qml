import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ohm

Window {
	id: root

	width: 400
	height: 300
	title: qsTr('Ohm example')

	visible: true
	color: palette.window

	function calculate(text: string) {
		const arithmetic = ohm.grammar(String.raw`
			Arithmetic {
				Exp
					= AddExp

				AddExp
					= AddExp "+" MulExp  -- plus
					| AddExp "-" MulExp  -- minus
					| MulExp

				MulExp
					= MulExp "*" ExpExp  -- times
					| MulExp "/" ExpExp  -- divide
					| ExpExp

				ExpExp
					= PriExp "^" ExpExp  -- power
					| PriExp

				PriExp
					= "(" Exp ")"  -- paren
					| "+" PriExp   -- pos
					| "-" PriExp   -- neg
					| number

				number  (a number)
					= digit* "." digit+  -- fract
					| digit+             -- whole
			}
		`)

		const s = arithmetic.createSemantics()
		s.addOperation('evaluate', {
			AddExp_plus(a, _, b) {
				return a.evaluate() + b.evaluate()
			},
			AddExp_minus(a, _, b) {
				return a.evaluate() - b.evaluate()
			},
			MulExp_times(a, _, b) {
				return a.evaluate() * b.evaluate()
			},
			MulExp_divide(a, _, b) {
				return a.evaluate() / b.evaluate()
			},
			ExpExp_power(a, _, b) {
				return a.evaluate() ** b.evaluate()
			},
			PriExp_paren(_, a, _) {
				return a.evaluate()
			},
			PriExp_pos(_, a) {
				return +a.evaluate()
			},
			PriExp_neg(_, a) {
				return -a.evaluate()
			},
			number_fract(_, _, _) {
				return parseFloat(this.sourceString)
			},
			number_whole(_) {
				return parseInt(this.sourceString)
			}
		})

		const m = arithmetic.match(text)
		if (m.succeeded()) {
			console.log('Everything is fine')
			const adapter = s(m)
			return adapter.evaluate()
		} else {
			console.log('Some error')
			return '?'
		}
	}

	GridLayout {
		anchors {
			left: parent.left
			right: parent.right
			top: parent.top
			margins: 10
		}
		columns: 2

		Label {
			text: 'Expression:'
			Layout.alignment: Qt.AlignRight
		}

		TextField {
			id: input
			Layout.fillWidth: true
		}

		Label {
			text: 'Result:'
			Layout.alignment: Qt.AlignRight
		}

		TextField {
			readOnly: true
			Layout.fillWidth: true
			text: `= ${root.calculate(input.text)}`
		}
	}
}
