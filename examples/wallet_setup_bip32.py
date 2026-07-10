"""Offline wallet setup example mirroring bdk-jvm WalletSetupBip32."""

from bdkpython import Descriptor
from bdkpython import DescriptorSecretKey
from bdkpython import KeychainKind
from bdkpython import Mnemonic
from bdkpython import Network
from bdkpython import NetworkKind
from bdkpython import Persister
from bdkpython import Wallet

# Sample/dev mnemonic only. Never use this for real funds.
SAMPLE_MNEMONIC = (
    "space echo position wrist orient erupt relief museum myself grain wisdom tumble"
)


def main() -> None:
    print("WARNING: This example uses a fixed sample mnemonic for demonstration only.")
    print("Do not use this mnemonic for real funds.")
    print(f"Sample mnemonic: {SAMPLE_MNEMONIC}")

    mnemonic = Mnemonic.from_string(SAMPLE_MNEMONIC)
    descriptor_secret_key = DescriptorSecretKey(NetworkKind.TEST, mnemonic, None)
    print(f"BIP32 root key: {descriptor_secret_key}")

    external_descriptor = Descriptor.new_bip84(
        descriptor_secret_key,
        KeychainKind.EXTERNAL,
        NetworkKind.TEST,
    )
    internal_descriptor = Descriptor.new_bip84(
        descriptor_secret_key,
        KeychainKind.INTERNAL,
        NetworkKind.TEST,
    )
    print(f"External descriptor: {external_descriptor}")
    print(f"Internal descriptor: {internal_descriptor}")

    persister = Persister.new_in_memory()
    wallet = Wallet(
        external_descriptor,
        internal_descriptor,
        Network.REGTEST,
        persister,
    )

    external_address = wallet.reveal_next_address(KeychainKind.EXTERNAL).address
    internal_address = wallet.reveal_next_address(KeychainKind.INTERNAL).address
    print(f"External address: {external_address}")
    print(f"Internal address: {internal_address}")
    print(f"Balance: {wallet.balance().total.to_sat()} sats")


if __name__ == "__main__":
    main()
