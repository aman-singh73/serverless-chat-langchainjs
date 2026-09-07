/**
 * Infriqa accuracy — new blob / file upload dependency (safe to delete).
 * Expected: file_upload + infra_change_required → tofu golden azure-storage-account.
 */
import { BlobServiceClient } from "@azure/storage-blob";

const CONTAINER = "uploads";

export function createUploadClient(accountUrl: string, credential: unknown) {
  const client = new BlobServiceClient(accountUrl, credential as any);
  return client.getContainerClient(CONTAINER);
}

export async function uploadBytes(
  container: ReturnType<typeof createUploadClient>,
  name: string,
  data: Buffer,
): Promise<void> {
  const block = container.getBlockBlobClient(name);
  await block.uploadData(data);
}
