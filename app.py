from langchain_community.llms import Ollama 
import streamlit as st

llm = Ollama(model="llama3.1:8b") #Specify model here

st.title("ISKOBOT")

prompt = st.text_area(label="Message ISKOBOT", label_visibility="hidden", placeholder="Message ISKOBOT")

if st.button("Ask"):
    if prompt:
        with st.spinner("Generating response..."):
            st.write_stream(llm.stream(prompt, stop=['<|eot_id|>']))
