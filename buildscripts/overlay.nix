final: prev:
# a fixed point overay for overriding a package set

with final; {
  # use the final result of the overlay for scope

  libtoxcore =
    # build a custom libtoxcore
    prev.libtoxcore.overrideAttrs ({ ... }: {
      src = fetchFromGitHub {
        owner = "TokTok";
        repo = "c-toxcore";
        rev = "e0b00d3e733148823e4b63d70f464e523ad62bac";
        fetchSubmodules = true;
        sha256 = "sha256-ofFoeC3gYAxknqATjqCF8um69kTTAaazs4yGouRe5Wc=";
      };
      patches = [
        ./patches/msgv3_addon.patch
        ./patches/tc___capabilites.patch
        ./patches/add_tox_group_get_grouplist_function.patch
        ./patches/add_tox_group_get_grouppeerlist_functions.patch
      ];
    });

  toxext = stdenv.mkDerivation rec {
    pname = "toxext";
    version = "0.0.3";
    src = fetchFromGitHub {
      owner = pname;
      repo = pname;
      rev = "v${version}";
      hash = "sha256-I0Ay3XNf0sxDoPFBH8dx1ywzj96Vnkqzlu1xXsxmI1M=";
    };
    nativeBuildInputs = [ cmake pkg-config ];
    buildInputs = [ libtoxcore ];
  };

  toxextMessages = stdenv.mkDerivation rec {
    pname = "tox_extension_messages";
    version = "0.0.3";
    src = fetchFromGitHub {
      owner = "toxext";
      repo = pname;
      rev = "v${version}";
      hash = "sha256-qtjtEsvNcCArYW/Zyr1c0f4du7r/WJKNR96q7XLxeoA=";
    };
    nativeBuildInputs = [ cmake pkg-config ];
    buildInputs = [ libtoxcore toxext ];
  };

  qtox = prev.qtox.overrideAttrs ({ buildInputs, ... }: {
    version = "push_notification-unstable";
    src = ./..;
    # take sources directly from this repo checkout
    buildInputs = buildInputs ++ [ curl libtoxcore toxext toxextMessages ];
  });

}
