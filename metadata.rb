name              "jbossas7"
maintainer        "Joshua Buysse, University of Minnesota"
maintainer_email  "buysse@umn.edu"
license           "Apache 2.0"
description       "Installs/configures JBoss AS 7."
version           "0.1.0"
recipe            "jbossas7", "Base JBoss AS 7 installation and configuration."
recipe            "jbossas7::configuration", "Attribute-driven configuration."

%w{ debian ubuntu }.each do |os|
  supports os
end

depends "ark"