cask "reviewhopper-xcode" do
  version "1.2.0"
  sha256 "5cfcaacaa731863b0356b7dbc758ded0a23aeda2233132b402b766b97eb6e4aa"

  url "https://github.com/jean-melikian/reviewhopper/archive/refs/tags/v#{version}.tar.gz"
  name "ReviewHopper Xcode"
  desc "App relais : ouvre un fichier à une ligne dans Xcode depuis l'extension ReviewHopper"
  homepage "https://github.com/jean-melikian/reviewhopper"

  depends_on macos: :ventura

  # L'app est construite sur la machine (signature ad hoc, pas de quarantaine) dans
  # ~/Applications, puis le schéma reviewhopper-xcode:// est enregistré.
  installer script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/reviewhopper-#{version}/helpers/xcode/install.sh"],
  }

  uninstall script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/reviewhopper-#{version}/helpers/xcode/install.sh", "--uninstall"],
  }

  caveats "Dans les réglages de l'extension ReviewHopper, choisir l'éditeur \"Xcode\"."
end
