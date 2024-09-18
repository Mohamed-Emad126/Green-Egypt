import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px
# Load data
data = pd.read_csv('Form.csv')
#Check for missing values
print("Missing values before cleaning:\n", data.isnull().sum())
#Drop rows where 'الاسم'is missing
data_cleaned = data.dropna(subset=['الاسم'])
#Drop rows where'لو فكرت قبل كده ففكره تساعد في انتشار المساحات الخضراء ممكن تشاركها معانا؟' is missing
data_cleaned = data.dropna(subset=['لو فكرت قبل كده ففكره تساعد في انتشار المساحات الخضراء ممكن تشاركها معانا؟'])
#Remove duplicate rows
data_cleaned = data_cleaned.drop_duplicates()
# Drop the columns
data = data.drop(columns=['الاسم', 'طابع زمني'])
# Sidebar for navigation

tabs = st.tabs(["Home", "Data Overview", "Visualizations", "Suggestions"])

# Page 1: Home
with tabs[0]:
    st.title("GO Green")
    st.image("https://www.shutterstock.com/image-vector/set-trees-3d-vector-icons-600nw-2294037383.jpg")
    st.subheader("About")
    st.markdown('''Green Egypt is an Android app designed to promote urban greening by encouraging citizens to plant
                trees and take care of existing ones The app provides tools and resources
                for individuals and communities to participate in tree planting initiatives track the health of trees
                and engage in community activities focused on environmental sustainability''')
# Page 2: Data Overview    
with tabs[1]:
    st.title("Survey Data Overview")
    st.write(data.head())

    st.subheader("Basic Statistics")
    st.write(data.describe())
     # Add filter by location
    st.subheader("Filter by Location")
    location = st.selectbox("Select a location", options=["All"] + list(data['موقعك الحالي'].unique()))
    
    # Filter data based on the selected location
    if location != "All":
        filtered_data = data[data['موقعك الحالي'] == location]
    else:
        filtered_data = data
    
    st.write(filtered_data.head())

    # Option to download filtered data
    st.subheader("Download Data")
    csv = filtered_data.to_csv(index=False).encode('utf-8')
    st.download_button("Download CSV", csv, "filtered_data.csv", "text/csv")
# Page 3: Visualizations     
with tabs[2]:
    st.title("Survey Data Visualizations")
    
    # Age Range Distribution
    st.subheader("Age Range Distribution")
    age_dist = data['ما هو عمرك؟'].value_counts().sort_index()
    fig = px.bar(age_dist, 
             x=age_dist.index, 
             y=age_dist.values, 
             labels={'x': 'Age Range', 'y': 'Count'},
             title="Age Range Distribution") 
    colors = ['#a8d5ba', '#7cb342', '#4caf50', '#388e3c', '#2c6b4f']  
    fig.update_traces(marker_color=colors)
    fig.update_traces(texttemplate='%{y}', textposition='outside')
    st.plotly_chart(fig)
    
    # Tree planting participation (as a pie chart)
    st.subheader("Have You Planted or Cared for a Tree?")
    tree_care = data['زرعت او اهتميت بشجره قبل كدا؟'].value_counts()
    fig, ax = plt.subplots()
    ax.pie(tree_care, labels=tree_care.index, autopct='%1.1f%%', startangle=90, colors=plt.cm.Paired.colors)
    ax.axis('equal') 
    st.pyplot(fig)
    #Is there a lot of trees in your city?
    st.subheader(" Is there a lot of trees in your city?")
    tree_presence = filtered_data['في شجر كتير في مدينتك؟'].value_counts()
    fig = px.bar(tree_presence, 
             x=tree_presence.index, 
             y=tree_presence.values, 
             labels={'x': 'Tree Presence', 'y': 'Count'}, 
             title="Are there a lot of trees in your city?",
             color_discrete_sequence=['#a5d6a7'])
    st.plotly_chart(fig)
   #Participation in Tree Planting
    st.subheader("Participation in Tree Planting - Sunburst Chart")
    fig = px.sunburst(filtered_data, 
                  path=['شاركت قبل كدا في زراعة الاشجار ف مدينتك؟'], 
                  title="Participation in Tree Planting in Your City")


    st.plotly_chart(fig) 
    
    #Do you have information on how to plant a tree?
    st.subheader("Participation in Tree Planting")
    fig = px.histogram(filtered_data, 
                   x='عندك معلومات عن ازاي تزرع الشجر؟', 
                   title="Do you have information on how to plant a tree?",
                   color_discrete_sequence=['#FF5733'])   
                    

    st.plotly_chart(fig)
    
    # Do you find it difficult to find information about tree planting?
    st.subheader(" Do you find it difficult to find information about tree planting?")
    difficulty_finding_info = filtered_data['في صعوبة في انك تلاقي معلومات عن زراعة الأشجار؟'].value_counts()
    fig = px.pie(difficulty_finding_info, 
             values=difficulty_finding_info.values, 
             names=difficulty_finding_info.index, 
             title="Difficulty Finding Information about Tree Planting",
             color_discrete_sequence=['#d0f0c0', '#a8d5ba', '#7cb342', '#4caf50', '#388e3c'],  
             hole=0.3)  
    fig.update_traces(textinfo='percent+label')
    st.plotly_chart(fig)             
    #Distribution of Garden or Outdoor Space Availability
    st.subheader("Distribution of Garden or Outdoor Space Availability")
    garden_space_counts = data['  عندك حديقة أو مساحة خارجية في بيتك تقدر تزرع شجر فيها؟  '].value_counts()
    cumulative_counts = garden_space_counts.cumsum()
    fig, ax = plt.subplots()
    cumulative_counts.plot(kind='bar', color=['#76b041', '#d95f02'], ax=ax)
    ax.set_title('Distribution of Garden or Outdoor Space Availability?', fontsize=16)
    ax.set_xlabel('result', fontsize=12)
    ax.set_ylabel('Cumulative number', fontsize=12)
    st.pyplot(fig)
# Page 4: Suggestions
with tabs[3]:
    st.title("Suggestions for Spreading Green Spaces")
    st.write(data[[ 'لو فكرت قبل كده ففكره تساعد في انتشار المساحات الخضراء ممكن تشاركها معانا؟']].dropna())