import subprocess
import sys
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
EXAMPLE_PATH = REPO_ROOT / "examples" / "wallet_setup_bip32.py"

EXPECTED_LABELS = [
    "WARNING",
    "Sample mnemonic:",
    "BIP32 root key:",
    "External descriptor:",
    "Internal descriptor:",
    "External address:",
    "Internal address:",
    "Balance:",
]


class OfflineExamplesTest(unittest.TestCase):
    def test_wallet_setup_bip32_example_runs(self) -> None:
        result = subprocess.run(
            [sys.executable, str(EXAMPLE_PATH)],
            cwd=REPO_ROOT,
            capture_output=True,
            text=True,
            check=False,
        )

        self.assertEqual(
            0,
            result.returncode,
            msg=f"Example failed.\nstdout:\n{result.stdout}\nstderr:\n{result.stderr}",
        )

        for label in EXPECTED_LABELS:
            self.assertIn(label, result.stdout)


if __name__ == "__main__":
    unittest.main()
