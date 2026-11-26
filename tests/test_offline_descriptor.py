import unittest

from bdkpython import (
    Descriptor,
    DescriptorPublicKey,
    DescriptorSecretKey,
    KeychainKind,
    Mnemonic,
    NetworkKind,
)


TEST_MNEMONIC = "space echo position wrist orient erupt relief museum myself grain wisdom tumble"
FINGERPRINT = "be1eec8f"

# Testnet account xpubs and descriptor checksums for the fixed test mnemonic.
TEMPLATES = [
    (
        44, Descriptor.new_bip44, Descriptor.new_bip44_public, "pkh({})",
        "tpubDDU4FgPLi7KS5ifs1oecUkWWShaanm8NcCWtU4YD6CBCBEmyXm8KFqhpE4jhTgdzMT596EHaXUQv8AgoWdojNd6rvkBo3ywcGuaCMpVzYQk",
        ("huk25z3s", "xgntfhpg"),
    ),
    (
        49, Descriptor.new_bip49, Descriptor.new_bip49_public, "sh(wpkh({}))",
        "tpubDCQUpc5Wyn6Awzi2hfygmy2YdDkyKe22gtSFoLu9JhGFUzkU9BCrCBCYdBtmKwdomzYLMPo5F2wtYT5afPkKRg5gRf2a5jeb1jnFJy43RCB",
        ("tut4uwqm", "7a9ry34y"),
    ),
    (
        84, Descriptor.new_bip84, Descriptor.new_bip84_public, "wpkh({})",
        "tpubDCEXgvX7SF8XoPqJ8Tazeq9A145PRiRV7wN4GXAeFhqHacAki3PUo8mvh2RGyYH1XbeWgfCvaSia27oGrAQaK5MnRi8EfuhdvXu2vLXXcch",
        ("w27v7s58", "l7mdr9yl"),
    ),
    (
        86, Descriptor.new_bip86, Descriptor.new_bip86_public, "tr({})",
        "tpubDCTtszwSxPx3tATqDrsSyqScPNnUChwQAVAkanuDUCJQESGBbkt68nXXKRDifYSDbeMa2Xg2euKbXaU3YphvGWftDE7ozRKPriT6vAo3xsc",
        ("m7puekcx", "22yayrg7"),
    ),
]

KEYCHAINS = [KeychainKind.EXTERNAL, KeychainKind.INTERNAL]


class OfflineDescriptorTest(unittest.TestCase):
    def test_bip_descriptors_from_secret_key(self):
        network = NetworkKind.TEST
        secret_key = DescriptorSecretKey(network, Mnemonic.from_string(TEST_MNEMONIC), None)

        for bip, create, _, script, xpub, checksums in TEMPLATES:
            for branch, keychain in enumerate(KEYCHAINS):
                with self.subTest(bip=bip, keychain=keychain):
                    key = f"[{FINGERPRINT}/{bip}'/1'/0']{xpub}/{branch}/*"
                    expected = f"{script.format(key)}#{checksums[branch]}"
                    self.assertEqual(str(create(secret_key, keychain, network)), expected)

    def test_bip_watch_only_descriptors(self):
        network = NetworkKind.TEST

        for bip, _, create, script, xpub, checksums in TEMPLATES:
            account_key = DescriptorPublicKey.from_string(xpub)
            for branch, keychain in enumerate(KEYCHAINS):
                with self.subTest(bip=bip, keychain=keychain):
                    key = f"[{FINGERPRINT}/{bip}'/1'/0']{xpub}/{branch}/*"
                    expected = f"{script.format(key)}#{checksums[branch]}"
                    self.assertEqual(
                        str(create(account_key, FINGERPRINT, keychain, network)), expected
                    )

    def test_sortedmulti_descriptors(self):
        keys = [
            "0325fc615a447a198f6c1e4e0c1078595b18fa7c4b6357ba91dbfd6e14d147e886",
            "025143bc0b791047e2e8892f2c0f973c6dcb879a7be56a3e72a78f82815d8a77dc",
            "030b2e5a6b08277b8b89efa156f1e0f2f5bfec9ed1266ffa6f19dc441fed2cdaed",
        ]
        policy = f"sortedmulti(2,{','.join(keys)})"
        self.assertEqual(str(Descriptor.new_wsh_sortedmulti(2, keys)), f"wsh({policy})#qya3xx6f")
        self.assertEqual(str(Descriptor.new_sh_sortedmulti(2, keys)), f"sh({policy})#uhfn3svt")


if __name__ == "__main__":
    unittest.main()
