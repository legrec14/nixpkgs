{ lib
, aiohttp
, aioresponses
, asynctest
, backoff
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, pytest-aiohttp
, pytestCheckHook
, pythonOlder
, pytz
, types-pytz
, voluptuous
}:

buildPythonPackage rec {
  pname = "simplisafe-python";
  version = "11.0.5";
  format = "pyproject";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "bachya";
    repo = pname;
    rev = version;
    sha256 = "sha256-QLxp7WrYXJDGVG/MZ+GpvzYZ8gyLwconqikgs581voI=";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [
    aiohttp
    backoff
    pytz
    types-pytz
    voluptuous
  ];

  checkInputs = [
    aioresponses
    asynctest
    pytest-aiohttp
    pytestCheckHook
  ];

  disabledTests = [
    # simplipy/api.py:253: InvalidCredentialsError
    "test_request_error_failed_retry"
    "test_update_error"
  ];

  disabledTestPaths = [ "examples/" ];

  pythonImportsCheck = [ "simplipy" ];

  __darwinAllowLocalNetworking = true;

  meta = with lib; {
    description = "Python library the SimpliSafe API";
    homepage = "https://simplisafe-python.readthedocs.io/";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
