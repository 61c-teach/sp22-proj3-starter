#!/usr/bin/env bash
set -eu

###########################################################
# Change the next line as needed if auto-detection fails. #
# When in doubt, ask on Piazza.                           #
#   e.g. python_exec="py"                                 #
###########################################################
python_exec=""
if [ -z "${python_exec}" ]; then
  if command -v py 2>&1 >/dev/null; then
    python_exec=py
  elif command -v python3 2>&1 >/dev/null; then
    python_exec=python3
  elif command -v python 2>&1 >/dev/null; then
    python_exec=python
  fi
fi
if [[ "$("${python_exec}" -c 'import sys; print(sys.version_info[0])')" -ne "3" ]]; then
  echo "Error: couldn't detect Python version. Is `${python_exec}` Python 3?"
  "${python_exec}" -V
  exit 1
fi

help() {
  echo "------------------------------HELP------------------------------"
  echo "To download Logisim & Venus, type: bash test.sh download_tools"
  echo "Part A:"
  echo "    To run all part A tests, type: bash test.sh part_a"
  echo "    To test ALU, type:             bash test.sh test_alu"
  echo "    To test RegFile, type:         bash test.sh test_regfile"
  echo "    To test addi, type:            bash test.sh test_addi"
  echo "Part B:"
  echo "    TODO"
  echo "----------------------------------------------------------------"
}

if [ -z "${1:-}" ]; then
  help
  exit 1
fi

case "${1}" in
  part_a)
    echo "Testing ALU:"
    "${python_exec}" tools/run_test.py ${@:2} tests/unit-alu/
    echo ""
    echo "Testing RegFile:"
    "${python_exec}" tools/run_test.py ${@:2} tests/unit-regfile/
    echo ""
    echo "Testing addi:"
    "${python_exec}" tools/run_test.py ${@:2} tests/integration-addi/
    ;;
  test_addi)
    "${python_exec}" tools/run_test.py ${@:2} tests/integration-addi/
    ;;
  test_alu)
    "${python_exec}" tools/run_test.py ${@:2} tests/unit-alu/
    ;;
  test_regfile)
    "${python_exec}" tools/run_test.py ${@:2} tests/unit-regfile/
    ;;
  part_b)
    echo "To be released"
    ;;
  create_test)
    "${python_exec}" tools/create_test.py ${@:2}
    ;;
  diff)
    "${python_exec}" tools/diff_output.py ${@:2}
    ;;
  format)
    "${python_exec}" tools/format_output.py ${@:2}
    ;;
  download_tools)
    "${python_exec}" tools/download_tools.py ${@:2}
    ;;
  *)
    help
    exit 1
    ;;
esac
