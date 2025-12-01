# Installation of Langflow with aiDAPTIV
## Pre-requisite 
1. You should have the aiDAPTIV server up and hosted on `http://localhost:13141/v1`.

## Setup
1. Navigate into the installer directory
2. Install the `aiDAPTIV_Langflow_Installer.exe`
3. Double click on the `aiDAPTIV Langflow.exe` and the app will automatically open a terminal window and begin the start up process.

## Application Setup and Access 
1. **Embedding Process**: The application will take a few moments to convert the documents into embeddings for the Retrieval Augmented Generation (RAG) process.
2. **Accessing Langflow:**: Once the terminal displays the message `Auto-run of loaded flows completed`, the web interface open automatically.

## Using the Default Flow
1. **Default Flow**: A pre-configured `Vector RAG` flow will be visible on the Langflow webpage.
2. **Enter the Playground**: Click on the `Vector RAG` flow. Click the `Playground` icon in the top right corner to enter the interactive chat interface.


## Asking Qeuestions (Testing)
- **Document Context:** You can now ask questions about the documents that were processed.
- **Golden Examples:** A set of test documents (`test_cytoplasm.txt` and `test_thyroidgland_insulin.txt`) has been pre-uploaded to the File node in the flow.
- **Fast Inference:** You can ask questions based on these golden examples for fast inference due to the reuse of the KV cache.

## Notes
- If the terminal shows `Golden Example exists`, it means that KV cache is already initialized for both documents uploaded in the LangFlow.
