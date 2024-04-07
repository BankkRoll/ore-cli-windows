use ore::TREASURY_ADDRESS;
use solana_client::nonblocking::rpc_client::RpcClient;
use solana_sdk::{commitment_config::CommitmentConfig, signature::Signer};

use crate::Miner;

impl Miner {
    pub async fn initialize(&self) {
        // Return early if program is initialized
        let signer = self.signer();
        let client =
            RpcClient::new_with_commitment(self.cluster.clone(), CommitmentConfig::confirmed());
        if client.get_account(&TREASURY_ADDRESS).await.is_ok() {
            return;
        }

        // Sign and send transaction.
        let ix = ore::instruction::initialize(signer.pubkey());
        self.send_and_confirm(&[ix], false)
            .await
            .expect("Transaction failed");
    }
}