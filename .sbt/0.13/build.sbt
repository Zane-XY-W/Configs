
import scalariform.formatter.preferences._

transitiveClassifiers := Seq("sources")

seq(npSettings: _*)

addCommandAlias("f", "scalariformFormat")

//https://github.com/sbt/sbt-scalariform
defaultScalariformSettings

ScalariformKeys.preferences := ScalariformKeys.preferences.value.setPreference(AlignSingleLineCaseStatements, true)