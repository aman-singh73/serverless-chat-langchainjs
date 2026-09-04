// Infriqa action-reasoning demo (safe to delete)
// Switches model id and calls an external OpenAI HTTP endpoint.
export const RAG_MODEL_ID = "gpt-4o-mini-demo";
export const EXTERNAL_ENDPOINT = "https://api.openai.com/v1/embeddings";

export async function callExternalModel(prompt: string) {
  const res = await fetch(EXTERNAL_ENDPOINT, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ model: RAG_MODEL_ID, input: prompt }),
  });
  return res.json();
}
