class TokenSaver < Formula
  desc "Transparent CLI proxy that compresses verbose command output for LLM agents"
  homepage "https://github.com/noah-hrbth/token-saver"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-aarch64-apple-darwin.tar.gz"
      sha256 "be4e8f3fd173f60fe877d9f56f17467af2ddb29ed840c5a7998ffc9a3c3dc848"
    end
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-apple-darwin.tar.gz"
      sha256 "df717e317f6720d3aeb5465f1dd9d0004c8f2eb60e7ce617cf3b9b6dc884575e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3fcdb3331cb35b1b6d32dafc5a08fee09fc1899a72edeaded29e3ffcd47ba2a"
    end
  end

  def install
    bin.install "token-saver"
  end

  def caveats
    <<~EOS
      token-saver is installed, but the shell wrappers must be enabled
      per-shell. Add ONE of the following to your shell startup file:

        # zsh — use ~/.zshenv (NOT ~/.zshrc) so it loads in the
        # non-interactive subshells Claude Code spawns:
        eval "$(token-saver init zsh)"

        # bash — add to ~/.bashrc:
        eval "$(token-saver init bash)"

      Then enable compression in your AI tool. For Claude Code,
      add to ~/.claude/settings.json:

        "env": { "TOKEN_SAVER": "1" }

      The wrappers are guarded by TOKEN_SAVER=1, so they are a
      no-op in normal shells.
    EOS
  end

  test do
    assert_match "token-saver #{version}", shell_output("#{bin}/token-saver --version")
  end
end
