import streamlit as st
from pathlib import Path as p
from pprint import pprint
import pandas as pd
from langchain import PromptTemplate
from langchain.chains.question_answering import load_qa_chain
from langchain.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.vectorstores import Chroma
from langchain.chains import RetrievalQA
from langchain.document_loaders import PDFPlumberLoader
from langchain_community.llms import Ollama
from langchain_ollama import OllamaEmbeddings

# Initialize the model
llm = Ollama(model="llama3.1:8b")  # Specify model here

# Streamlit UI
st.title("Iskobot")

# Load PDF and prepare documents for retrieval
pdf_loader = PDFPlumberLoader("../pdfs/Studying-101.pdf")
pages = pdf_loader.load_and_split()

# Split the PDF content into smaller chunks for processing
text_splitter = RecursiveCharacterTextSplitter(chunk_size=10000, chunk_overlap=1000)
context = "\n\n".join(str(p.page_content) for p in pages)
texts = text_splitter.split_text(context)

# Generate embeddings and create a vector store for retrieval
embeddings = OllamaEmbeddings(model='jina/jina-embeddings-v2-base-en',) # Specify embedding model here
vector_index = Chroma.from_texts(texts, embeddings).as_retriever(search_kwargs={"k": 5})

# Define the prompt template for the retrieval QA chain
template = """You are Iskobot, a chatbot designed to assist students with their general and academic questions. Use the context provided to answer the question below. If you don't know the answer, clearly state that you don't know, and avoid guessing. Provide a concise response and include "Thanks for asking!" at the end of your answer.
{context}
Question: {question}
Answer:"""
QA_CHAIN_PROMPT = PromptTemplate.from_template(template)

# Create the retrieval QA chain
qa_chain = RetrievalQA.from_chain_type(
    llm,
    retriever=vector_index,
    return_source_documents=True,
    chain_type_kwargs={"prompt": QA_CHAIN_PROMPT}
)

# Streamlit input and button
prompt = st.text_area(label="Message Iskobot", label_visibility="hidden", placeholder="Message Iskobot")

# Button to trigger the QA process
if st.button("Ask"):
    if prompt:
        with st.spinner("Answering your question..."):
            # Use the retrieval QA chain to get an answer
            result = qa_chain({"query": prompt})
            st.write(result['result'])
            st.write("Thanks for asking!")
