# [Ohm.js](https://ohmjs.org/) for QML

This is a slightly modified Ohm.js version **16.6.0** adapted to be used with QML.

⚠️ Due to limitations of the QML's JavaScript environment (which is still based on ECMAScript 2016), it's not possible to upgrade Ohm.js to 17.x.

## Usage

```qml
import QtQml

import ohm  // 1) import

QtObject {
	Component.onCompleted: {
		const g = ohm.grammar(...)  // 2) ohm is already available
	}
}
```

### Connect the module with Qbs

If in your project you rely on Qbs, it should be easy to connect the QML module as following:

```qml
Project {
	// ...

	SubProject {
		filePath: '3rdParty/ohm.qml/project.qbs'
		Properties {
			installPrefix: 'path/to/imports/'
		}
	}

	// ...
}
```
