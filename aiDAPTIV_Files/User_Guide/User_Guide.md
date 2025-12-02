# aiDAPTIV Langflow User Guide 
## Overview 
This guide explains how to install, configure, and use Langflow integrated with aiDAPTIV. It also covers how to run the default Vector RAG flow, test KV-cache-accelerated inference using golden examples, and understand the system’s startup behaviors.

## Chapter 1: Installation and Setting
### Installation Steps
#### Prerequisites
1. Ensure the aiDAPTIV server is running and available at `http://localhost:13141/v1`
#### Setup
1. Navigate to the **installer** directory
2. Install the `aiDAPTIV_Langflow_Installer.exe`
3. Launch the application by double clicking `aiDAPTIV Langflow.exe`. This will open a terminal window where the system automatically starts Langflow..

## Chapter 2: How to Use?
### Usage Workflow
1. **Initial Setup**
- When the application starts, it will automatically begin an embedding process, converting documents into vector embeddings for the Retrieval-Augmented Generation (RAG) pipeline.
- Wait until the terminal shows the message:
`Auto-run of loaded flows completed`.
Once this appears, Langflow’s web interface will open automatically in your browser.
2. **Basic Operation**
- **Accessing the Default Flow**: 
    - A preconfigured flow named `Vector Store RAG - KV cache Generation` will appear on the Langflow webpage.
    - Click on `Vector Store RAG - KV cache Generation`.
    - Then click the `Playground` icon (**top-right** corner) to enter the interactive chat interface.

- **Using Example Files (Golden Workflow for KV Cache)**
    - Two golden example files have already been uploaded in the File node
        - test_cytoplasm.txt
        - test_thyroidgland_insulin.txt

3. **Advanced Features**:
- **Asking Questions (Testing)**
    - You may now ask questions related to the uploaded documents.
    - If KV cache has already been created for a document, inference will be significantly faster.
    - When the terminal displays: `Golden Example exists`, it indicates that both example documents already have an initialized KV cache, enabling faster responses.
- **Test with uploaded customized documents**
    - You may test the system with your own uploaded documents. 
    - First, run the `Load Data Flow` at the bottom of the page to embed your customzed documents
    - After the embedding completes, proceed to run the `Retrieval Flow` to generate the KV cache for those documents.

## Chapter 3: Troubleshooting (Optional)
### Issue 1: Slow Start-Up or Delayed Embedding Process
- **Symptoms**:
    - Terminal appears stuck during `embedding documents`
    - Langflow webpage doesn't open automatically
- **Solution**:
    - Wait at least `1-3 minutes`, depending on the number of documents being processed.
    - Ensure the aiDAPTIV server at `http://localhost:13141/v1` is running before launching Langflow.
    - Open Langflow manually via `http://localhost:7860` and verify that all required fields are populated in every node:
        - `OPENAI_API_KEY`
        - `OPENAI_API_BASE`
        - `OPENAI_API_BASE_EMBEDDING` 
        - (These are typically auto-filled when the application starts.)
- **Verification**:
    - Check for the terminal message: `Auto-run of loaded flows completed`
    - Confirm that the default Vector RAG flow appears in the UI.