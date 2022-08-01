import jenkins.model.*
Jenkins.instance.setNumExecutors(3) // Recommended to not run builds on the built-in node
