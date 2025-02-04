{ lib
, buildPythonPackage
, fetchPypi
, isPy27
, setuptools-scm
, vcver
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "deepmerge";
  version = "1.1.0";
  disabled = isPy27;
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-TCeg213iheGnzqx9vBUx3qpVa2J96kkAyCRFgezf6i0=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "deepmerge" ];

  meta = with lib; {
    description = "A toolset to deeply merge python dictionaries.";
    homepage = "http://deepmerge.readthedocs.io/en/latest/";
    license = licenses.mit;
    maintainers = with maintainers; [ hexa ];
  };
}
