{ stdenv, fetchFromGitHub, rustPlatform, pkgconfig, openssl
, darwin
}:

with rustPlatform;

buildRustPackage rec {
  pname = "chit";
  version = "0.1.12";

  src = fetchFromGitHub {
    owner = "peterheesterman";
    repo = pname;
    rev = version;
    sha256 = "17g2p07zhf4n4pjmws0ssfy2mrn0v933ih0vnlr1z2cv9mx8srsl";
  };

  cargoSha256 = "1jqnnf4jgjpm1i310hda15423nxfw9frgpmc2kbrs66qcsj7avaw";

  nativeBuildInputs = stdenv.lib.optionals stdenv.isLinux [ pkgconfig ];
  buildInputs = []
  ++ stdenv.lib.optionals stdenv.isLinux [ openssl ]
  ++ stdenv.lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices Security ])
  ;

  # Tests require network access
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Crate help in terminal: A tool for looking up details about rust crates without going to crates.io";
    longDescription = ''
      Chit helps answer these questions:

      * Who wrote this crate? What else did they write?
      * What alternatives are there?
      * How old is this crate?
      * What versions are there? When did they come out?
      * What are the downloads over time?
      * Should i use this crate?
      * How mature is it?
    '';
    homepage = https://github.com/peterheesterman/chit;
    license = licenses.mit;
    maintainers = [ maintainers.lilyball ];
    platforms = platforms.all;
  };
}
