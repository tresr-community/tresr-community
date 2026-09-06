{
  pkgs,
  config,
  lib,
  ...
}:
let
  packages = with pkgs; [
    bashInteractive
  ];

  devPackages = with pkgs; [
    figlet
    git
    hugo
    jq
    wrangler
    yq-go
  ];
in
{
  name = "tresr community";

  env = {
    PROJECT = config.name;
  };

  cachix = {
    enable = false;
    pull = [
      "tresr-community"
    ];
    push = "tresr-community";
  };

  devenv = {
    warnOnNewVersion = true;
  };

  dotenv = {
    enable = true;
    disableHint = false;
  };

  packages = packages ++ lib.optionals (!config.container.isBuilding) devPackages;

  enterShell = ''
    if [[ "''${CI:-false}" == "true" ]]; then
      echo "devenv running in CI"
    else
      figlet -f slant -w 180 "$(echo "$PROJECT" | tr '[:lower:]-' '[:upper:] ')"

      hello --greeting="Hello ''${USER:-user}, welcome to the $PROJECT project."

      ${lib.optionalString (config.scripts != { }) ''
        echo ""
        echo "#########################"
        echo "#### Helper scripts #####"
        echo "#########################"
        echo "🦾"
        ${lib.concatStrings (
          lib.mapAttrsToList (
            name: value: "printf '🦾 %-20s  %s\\n' '${name}' '${value.description}'\n"
          ) config.scripts
        )}
        echo "🦾"
        echo "#########################"
      ''}
    fi
  '';

  languages = {
    nix = {
      enable = true;
    };
    shell = {
      enable = true;
    };
    go = {
      enable = true;
    };
    javascript = {
      enable = true;
      bun = {
        enable = true;
      };
      npm = {
        enable = true;
      };
    };
  };

  difftastic = {
    enable = true;
  };

  git-hooks = {
    excludes = [
      "_vendor/"
      "themes/"
      "vendor/"
    ];
    hooks = {
      actionlint.enable = true;
      action-validator.enable = true;
      cargo-check.enable = false;
      check-json.enable = true;
      check-merge-conflicts.enable = true;
      check-shebang-scripts-are-executable.enable = true;
      check-symlinks.enable = true;
      check-yaml.enable = true;
      clippy = {
        enable = false;
        settings = {
          denyWarnings = true;
          offline = true;
          allFeatures = true;
          #extraArgs = "--target wasm32-unknown-unknown";
        };
      };
      commitizen.enable = true;
      convco = {
        enable = true;
        settings = {
          configPath = ".versionrc";
        };
      };
      deadnix.enable = true;
      dialyzer.enable = true;
      editorconfig-checker.enable = true;
      gptcommit.enable = true;
      markdownlint = {
        enable = true;
        settings = {
          configuration = {
            MD013 = {
              line_length = 250;
            };
            MD033 = {
              allowed_elements = [
                "a"
                "br"
                "nobr"
                "pre"
                "sup"
                "div"
              ];
            };
          };
        };
      };
      mixed-line-endings.enable = true;
      nixfmt.enable = true;
      pre-commit-hook-ensure-sops.enable = true;
      prettier = {
        enable = true;
        settings = {
          configPath = ".prettierrc.yaml";
        };
      };
      pretty-format-json = {
        enable = false;
        excludes = [ ];
      };
      revive = {
        enable = true;
        fail_fast = false;
      };
      ripsecrets = {
        enable = true;
        excludes = [ ];
      };
      rustfmt.enable = true;
      shellcheck = {
        enable = true;
        excludes = [ ];
      };
      shfmt.enable = true;
      staticcheck.enable = true;
      statix.enable = true;
      trim-trailing-whitespace.enable = true;
      trufflehog.enable = true;
      typos = {
        enable = true;
        settings = {
          configPath = ".typos.toml";
          exclude = "static/**";
        };
      };
      yamllint = {
        enable = true;
        settings = {
          configuration = ''
            extends: relaxed
            rules:
              line-length: disable
              indentation: enable
          '';
        };
      };
    };
  };

  starship = {
    enable = true;
    config = {
      enable = false;
    };
  };

  devcontainer = {
    enable = true;
    settings = {
      customizations = {
        vscode = {
          extensions = [
            "arrterian.nix-env-selector"
            "esbenp.prettier-vscode"
            "github.vscode-github-actions"
            "golang.go"
            "gruntfuggly.todo-tree"
            "johnpapa.vscode-peacock"
            "mkhl.direnv"
            "nhoizey.gremlins"
            "pinage404.nix-extension-pack"
            "redhat.vscode-yaml"
            "streetsidesoftware.code-spell-checker"
            "tekumura.typos-vscode"
            "timonwong.shellcheck"
            "tuxtina.json2yaml"
            "vscodevim.vim"
            "wakatime.vscode-wakatime"
            "yzhang.markdown-all-in-one"
          ];
        };
      };
    };
  };

  enterTest = ''
    echo "Running devenv tests..."
  '';
}
