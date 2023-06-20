import qbs

Project {
	property string installPrefix: qbs.installPrefix

	references: [
		'extensions/extensions.qbs',
	]
}
