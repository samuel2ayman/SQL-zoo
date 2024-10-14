--1.List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--2.Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

select name from world
where gdp/population >(select gdp/population from world where name='United Kingdom'  ) AND continent='Europe'

--3.List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

select name , continent from world
where continent in (select continent from world where name in ('Argentina','Australia')) 
order by name

--4.Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

select name , population from world 
where population > (select population from world where name='United Kingdom') and
      population < (select population from world where name='Germany')

--5.Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

select name ,concat(round(100* population/(select population from world where name ='Germany')), '%') from world
where continent ='Europe'weq2

--6.Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

select name from world 
where gdp > ALL (select gdp from world where continent = 'Europe' AND gdp IS NOT NULL) 

--7.Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

--8.List each continent and the name of the country that comes first alphabetically.

select continent ,min(name) from world
group by continent


--9.Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. 
--Show name, continent and population.
SELECT name ,continent, population 
  FROM world w1
  WHERE 25000000 >= all(SELECT population 
    FROM world w2
      where w1.continent=w2.continent)

--10.Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

SELECT name,continent 
  FROM world w1 
   WHERE population > ALL (SELECT population*3 
     FROM world w2 
      WHERE w1.continent=w2.continent 
       and w1.name!=w2.name)