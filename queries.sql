select *
from covid..Deaths
order by 3,4

select *
from covid..Vaccinations
where continent is not null
order by 3,4

-- Select Data that we are got to be using
select location, date, total_cases, new_cases, total_deaths, population
from covid..Deaths
where continent is not null
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Show likelihood of dying if you contract covid in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from covid..Deaths
where location like '%states%'
and continent is not null
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from covid..Deaths
where location like '%states%'
and continent is not null
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to population
select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from covid..Deaths
where continent is not null
group by location, population
order by PercentPopulationInfected DESC

-- LET'S BREAK THINGS DOWN BY CONTINENT
-- Showing continents with the highest death per population
select continent, MAX(cast(total_deaths as bigint)) as TotalDeathCount
from covid..Deaths
where continent is not null
group by continent
order by TotalDeathCount DESC

-- GLOBAL NUMBERS

select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as bigint)) as total_deaths, 
	SUM(cast(new_deaths as bigint))/SUM(new_cases)*100 as DeathPercentage
from covid..Deaths
where continent is not null
group by date
order by 1,2

-- Loking at Total Population vs Vaccinations

-- CTE
with PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as (
	select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
		SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (partition by dea.location 
		order by dea.location, dea.date) as RollingPeopleVaccinated
	from covid..Deaths dea
	join covid..Vaccinations vac
		on dea.location = vac.location
		and dea.date = vac.date
	where dea.continent is not null
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac
order by 2,3

-- TEMP TABLE
DROP table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated (
	Continent nvarchar(255), 
	Location nvarchar(255), 
	Date datetime, 
	Population numeric, 
	New_vaccinations numeric, 
	RollingPeopleVaccinated numeric
)
insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (partition by dea.location 
	order by dea.location, dea.date) as RollingPeopleVaccinated
from covid..Deaths dea
join covid..Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


-- Creating view to store data for later visualizations
create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (partition by dea.location 
	order by dea.location, dea.date) as RollingPeopleVaccinated
from covid..Deaths dea
join covid..Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

select * 
from PercentPopulationVaccinated