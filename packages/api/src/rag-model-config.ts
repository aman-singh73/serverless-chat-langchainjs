// rag-model-config.ts

// Configuration for RAG model

const externalApiUrl = 'https://api.openai.com/v1';

// Function to verify if the external API is reachable
async function verifyApiReachability() {
    try {
        const response = await fetch(externalApiUrl);
        if (!response.ok) {
            throw new Error('API is not reachable');
        }
        console.log('API is reachable');
    } catch (error) {
        console.error('Error reaching API:', error);
    }
}

verifyApiReachability();
