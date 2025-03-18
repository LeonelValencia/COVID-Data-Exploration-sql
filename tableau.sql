-- 1. 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as bigint)) as total_deaths, SUM(cast(new_deaths as bigint))/SUM(New_Cases)*100 as death_percentage
From covid..Deaths
where continent is not null 
order by 1,2

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Location

--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as bigint)) as total_deaths, SUM(cast(new_deaths as bigint))/SUM(New_Cases)*100 as DeathPercentage
--From covid..Deaths
----Where location like '%states%'
--where location = 'World'
----Group By date
--order by 1,2


-- 2. 
-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as bigint)) as total_death_count
From covid..Deaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by total_death_count desc


-- 3.

Select location, population, MAX(total_cases) as highest_infection_count,  Max((total_cases/population))*100 as percent_population_infected
From covid..Deaths
Group by Location, Population
order by percent_population_infected desc


-- 4.

Select location, population,date, MAX(total_cases) as highest_infection_count,  Max((total_cases/population))*100 as percent_population_infected
From covid..Deaths
Group by Location, Population, date
order by percent_population_infected desc