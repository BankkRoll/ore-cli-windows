use solana_client::nonblocking::rpc_client::RpcClient;
use solana_sdk::{commitment_config::CommitmentConfig, signature::Signer};

use crate::{utils::proof_pubkey, Miner};

impl Miner {
    pub async fn register(&self) {
        // Return early if miner is already registered
        let signer = self.signer();
        let proof_address = proof_pubkey(signer.pubkey());
        let client =
            RpcClient::new_with_commitment(self.cluster.clone(), CommitmentConfig::confirmed());
        if client.get_account(&proof_address).await.is_ok() {
            return;
        }

        // Sign and send transaction.
        println!("Generating challenge...");
        let ix = ore::instruction::register(signer.pubkey());
        self.send_and_confirm(&[ix], true, false)
            .await
            .expect("Transaction failed");
    }
}