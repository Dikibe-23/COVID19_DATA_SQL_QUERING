-- infection rate and death rate of Germany and the United Kingdom

--select continent, location, date, total_cases, new_cases, population, total_deaths, (total_deaths/population) *100 as percentage_death_rate, (total_cases/population)
--* 100 as percentage_infection_rate
--from covid19_deaths where location in('Germany', 'United Kingdom')
--order by location

select * from covid19_vacc

update covid19_vacc
set continent = 'Asia'
where location  = 'Asia'


--select continent, location, date, SUM(cast(total_vaccinations as bigint)) over (partition by v.continent order by v.continent, v.date) as sumofvaccinations from covid19_vacc v
--order by date DESC


-- joining tables

--select * from covid19_deaths d
--join covid19_vacc v
--on d.location = v.location
--and d.date = v.date

-- comparing information from Africa and Europe in separate queries;

select d.continent, d.location, d.date, total_deaths, v.total_vaccinations, v.people_fully_vaccinated, v.population from covid19_deaths d
join covid19_vacc v
on 
d.location = v.location and 
d.date = v.date
where d.continent in ('Africa')

order by 2

-- For Europe

select d.continent, d.location, d.date, total_deaths, v.total_vaccinations, v.people_fully_vaccinated, v.population from covid19_deaths d
join covid19_vacc v
on 
d.location = v.location and 
d.date = v.date
where d.continent in ('Europe')

order by 2

-- Next we want to have a close look at the yearly sum between both continents

select d.continent, d.location, d.date, d.total_deaths, v.people_fully_vaccinated, d.population, sum(cast(d.total_deaths as bigint)) over (partition by d.continent) 
as sum_totaldeaths from covid19_deaths d
join covid19_vacc v
on
d.date >= v.date
where d.continent in ('Europe', 'Africa') 

order by d.continent

select d.continent, d.location, d.total_deaths, sum(convert(bigint, d.total_deaths)) over(partition by d.location order by d.date) as sum_totaldeaths 
from covid19_deaths d
JOIN covid19_vacc v
On
d.date >= v.date
where d.continent in ('Africa', 'Europe')
order by d.date

select * from covid19_deaths

--cummulative covid 19 deaths partitioned by location

select continent, location, date, total_deaths, sum(cast(new_deaths as bigint)) over(partition by location order by date) as cumm_totaldeaths, population from covid19_deaths
where continent in ('Africa', 'Europe')
order by location , date

--cummulative covid 19 cases partitioned by loaction

select continent, location, date, total_cases, new_cases, sum(convert(bigint, new_cases)) over (partition by location order by date) as cumm_cases
from covid19_vacc
where continent in ('Africa', 'Europe')
order by location, date


-- let find the cummulative sum by date

select d.continent, d.location, d.date, sum(cast(d.new_deaths as bigint)) over (partition by d.location order by d.date) as cummulative_newdeaths from covid19_deaths d
join covid19_deaths d2
on d.date >= d2.date
where d.continent in ('Africa', 'Europe')
order by d.date



select continent, location, population, YEAR(date) as year, total_cases, new_cases, SUM(CAST(new_cases as bigint)) OVER (partition by location order by date)
as cumm_newcases from covid19_vacc
where continent in ('Africa', 'Europe')
order by continent, year