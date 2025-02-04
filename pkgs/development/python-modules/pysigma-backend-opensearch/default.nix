{ lib
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, pysigma
, pysigma-backend-elasticsearch
, pytestCheckHook
, pythonOlder
, requests
}:

buildPythonPackage rec {
  pname = "pysigma-backend-opensearch";
  version = "0.1.4";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "SigmaHQ";
    repo = "pySigma-backend-opensearch";
    rev = "refs/tags/v${version}";
    hash = "sha256-ZcX8LK/qckNEhMWljv73QHtWv4IY7Xtr4ISrlnrUaAY=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    pysigma
    pysigma-backend-elasticsearch
  ];

  checkInputs = [
    pytestCheckHook
    requests
  ];

  pythonImportsCheck = [
    "sigma.backends.opensearch"
  ];

  disabledTests = [
    # Tests requires network access
    "test_connect_lucene"
  ];

  meta = with lib; {
    description = "Library to support OpenSearch for pySigma";
    homepage = "https://github.com/SigmaHQ/pySigma-backend-opensearch";
    changelog = "https://github.com/SigmaHQ/pySigma-backend-opensearch/releases/tag/v${version}";
    license = with licenses; [ lgpl21Only ];
    maintainers = with maintainers; [ fab ];
  };
}
