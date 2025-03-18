# COVID Portafolio Project - Data Exploration

## Description
![covid dasboard](https://github.com/user-attachments/assets/f7a29b4f-5cba-41a3-b41b-d282f295ca6c)
https://public.tableau.com/app/profile/leonel.valencia/viz/CovidDashboard_17422591390370/Dashboard1
- **Data integration and cleaning:** Import, transformation and cleaning process of data sets.
- **Exploratory analysis:** Exploration of the data in SQL Server.
- **Visualization:** Generation of graphs in Tableau Public and presentation of results through interactive dashboards.

## Data Set
The project utilizes the dataset - https://ourworldindata.org/covid-deaths

## Requirements.
- **SQL Server Management Studio**
- **Tableau Public**
  
## Installation and Use

1. **Clone the repository:**

   ```bash
   git clone https://github.com/LeonelValencia/covid-data-exploration.git
    ```

2. Download the files CovidDeaths.xlsx and CovidVaccinations.xlsx in data/processed

3. In Microsoft SQL Server Managment or other RDBMS create a database called covid.

4. With the App "SQL Server 2022 Import and Export Data" import the data to the database or in MS SQL Server select the db and right clic select Task > Import. Then select Microsoft Excel as Data source and chose the excel file path.
5. Open the file queries.sql in SQL Server to explore the data
6. As Tableau Public does not allow to connect to databases then we have to save the results of the queries in excel files, which are already in data/processed.
