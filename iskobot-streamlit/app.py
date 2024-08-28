from langchain_community.llms import Ollama 
import streamlit as st

llm = Ollama(model="llama3.1:8b") #Specify model here

st.title("Iskobot")

prompt = st.text_area(label="Message Iskobot", label_visibility="hidden", placeholder="Message Iskobot")

if st.button("Ask"):
    if prompt:
        with st.spinner("Answering your question..."):
            st.write_stream(llm.stream(prompt, stop=['<|eot_id|>']))
