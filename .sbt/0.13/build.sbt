
import scalariform.formatter.preferences._

transitiveClassifiers in Global := Seq(Artifact.SourceClassifier)

addCommandAlias("f", "scalariformFormat")

//https://github.com/sbt/sbt-scalariform
defaultScalariformSettings

ScalariformKeys.preferences := ScalariformKeys.preferences.value.setPreference(AlignSingleLineCaseStatements, true)
