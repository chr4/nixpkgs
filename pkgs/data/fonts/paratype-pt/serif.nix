# when changing this expression convert it from 'fetchzip' to 'stdenvNoCC.mkDerivation'
{ lib, fetchzip }:

(fetchzip {
  name = "paratype-pt-serif";

  urls = [
    "https://company.paratype.com/system/attachments/634/original/ptserif.zip"
    "http://rus.paratype.ru/system/attachments/634/original/ptserif.zip"
  ];

  sha256 = "1iw5qi4ag3yp1lwmi91lb18gr768bqwl46xskaqnkhr9i9qp0v6d";

  meta = with lib; {
    homepage = "http://www.paratype.ru/public/";
    description = "An open Paratype font";

    license = "Open Paratype license";
    # no commercial distribution of the font on its own
    # must rename on modification
    # http://www.paratype.ru/public/pt_openlicense.asp

    platforms = platforms.all;
    maintainers = with maintainers; [ raskin ];
  };
}).overrideAttrs (_: {
  postFetch = ''
    mkdir -p $out/share/{doc,fonts}
    unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
    unzip -j $downloadedFile \*.txt -d $out/share/doc/paratype
  '';
})
