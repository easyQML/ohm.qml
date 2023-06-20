import qbs

Product {
	name: 'ohm.qml'

	Group {
		name: 'QML files'
		files: ['**']
		prefix: 'qml/'
		qbs.installPrefix: project.installPrefix
		qbs.installSourceBase: prefix
		qbs.install: true
	}
}
