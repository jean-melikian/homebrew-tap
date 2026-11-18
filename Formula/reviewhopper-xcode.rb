class ReviewhopperXcode < Formula
  desc "App relais : ouvre un fichier à une ligne dans Xcode depuis l'extension ReviewHopper"
  homepage "https://github.com/jean-melikian/reviewhopper"
  url "https://github.com/jean-melikian/reviewhopper/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c454b9713dee4870e5d036244ea53856845586acabdc94cc6ae07f26edacf712"

  depends_on :macos

  LSREGISTER = "/System/Library/Frameworks/CoreServices.framework/Frameworks/" \
               "LaunchServices.framework/Support/lsregister".freeze

  def app
    prefix/"ReviewHopper Xcode.app"
  end

  def install
    # L'app est construite sur la machine (pas de quarantaine Gatekeeper, signature ad hoc).
    with_env(REVIEWHOPPER_APP: app.to_s, REVIEWHOPPER_NO_REGISTER: "1") do
      system "/bin/bash", "helpers/xcode/install.sh"
    end
  end

  def post_install
    # Enregistre le schéma reviewhopper-xcode:// auprès de macOS.
    system LSREGISTER, "-f", opt_prefix/"ReviewHopper Xcode.app"
  end

  def caveats
    <<~EOS
      Dans les réglages de l'extension ReviewHopper, choisir l'éditeur "Xcode".
      Si les liens reviewhopper-xcode:// ne s'ouvrent pas, enregistrer l'app à la main :
        #{LSREGISTER} -f "#{opt_prefix}/ReviewHopper Xcode.app"
    EOS
  end

  test do
    plist = opt_prefix/"ReviewHopper Xcode.app/Contents/Info.plist"
    assert_match "reviewhopper-xcode",
                 shell_output("/usr/libexec/PlistBuddy -c 'Print :CFBundleURLTypes:0:CFBundleURLSchemes:0' '#{plist}'")
  end
end
