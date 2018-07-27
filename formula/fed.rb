require "formula"

class Fed < Formula
  desc "CLI to deploy Frontend modules"
  homepage "https://github.com/spotim/fed-cli"
  url "https://github.com/SpotIM/fed-cli/releases/download/v0.1.1/fed-cli-darwin-amd64", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "2f0007a1372f44628e988b1eaeb58fffc12582eb"

  # depends_on "cmake" => :build

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/spotim/fed-cli"
    # Copy all files from their current location (GOPATH root)
    # to $GOPATH/src/github.com/spotim/fed-cli
    bin_path.install Dir["*"]
    cd bin_path do
      # Install the compiled binary into Homebrew's `bin` - a pre-existing
      # global variable
      system "go", "build", "-o", bin/"fed", "."
    end
  end

  # Homebrew requires tests.
  test do
    # "2>&1" redirects standard error to stdout. The "2" at the end means "the
    # exit code should be 2".
    assert_match "fed version 1.0.0", shell_output("#{bin}/fed -v", 2)
  end
end
