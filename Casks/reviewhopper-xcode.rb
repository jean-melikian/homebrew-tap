cask "reviewhopper-xcode" do
  version "0.1.0"
  sha256 "c454b9713dee4870e5d036244ea53856845586acabdc94cc6ae07f26edacf712"

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
