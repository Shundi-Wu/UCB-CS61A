# Discussion 11

### Pizza Time

The `pizzas` table contains the names, opening, and closing hours of great pizza places in Berkeley. The `meals` table contains typical meal times (for college students). A pizza place is open for a meal if the meal time is at or within the `open` and `close` times.

```sqlite
CREATE TABLE pizzas AS
  SELECT "Artichoke" AS name, 12 AS open, 15 AS close UNION
  SELECT "La Val's"         , 11        , 22          UNION
  SELECT "Sliver"           , 11        , 20          UNION
  SELECT "Cheeseboard"      , 16        , 23          UNION
  SELECT "Emilia's"         , 13        , 18;

CREATE TABLE meals AS
  SELECT "breakfast" AS meal, 11 AS time UNION
  SELECT "lunch"            , 13         UNION
  SELECT "dinner"           , 19         UNION
  SELECT "snack"            , 22;
```

### Question 1: Open Early

You'd like to have pizza before 13 o'clock (1pm). Create a `opening` table with the names of all pizza places that `open` before 13 o'clock, listed in reverse alphabetical order.

```sqlite
-- Pizza places that open before 1pm in alphabetical order
CREATE TABLE opening AS
	SELECT name FROM pizzas WHERE open < 13 ORDER BY name DESC;
```

### Question 2: Study Session

You're planning to study at a pizza place from the moment it opens until 14 o'clock (2 pm). Create a table `study` with two columns, the `name` of each pizza place and the `duration` of the study session you would have if you studied there (the difference between when it opens and 14 o'clock). For pizza places that are not open before 2 pm, the `duration` should be zero. Order the rows by decreasing duration.

```sqlite
-- Pizza places and the duration of a study break that ends at 14 o'clock
SELECT name, MAX(14 - open, 0) AS duration FROM pizzas ORDER BY duration DESC;
```

### Question 3: Late Night Stack

What's still open for a late night `snack`? Create a `late` table with one column named `status` that has a sentence describing the closing time of each pizza place that closes at or after `snack` time. **Important:** Don't use any numbers in your SQL query! Instead, use a join to compare each restaurant's closing time to the time of a snack. The rows may appear in any order.

```sqlite
-- Pizza places that are open for late-night-snack time and when they close
CREATE TABLE late as
  SELECT name || " closes at " || close AS status
  FROM pizzas, meals
  WHERE close >= time and meal = "snack";
```

### Q4: Double Pizza

If two meals are more than 6 hours apart, then there's nothing wrong with going to the same pizza place for both, right? Create a `double` table with three columns. The `first` column is the earlier meal, the `second` column is the later meal, and the `name` column is the name of a pizza place. Only include rows that describe two meals that are **more than 6 hours apart** and a pizza place that is open for both of the meals. The rows may appear in any order.

```sqlite
-- Two meals at the same place
CREATE TABLE double AS
  SELECT a.meal AS first, b.meal AS second, name
  FROM meals AS a, meals AS b, pizzas
  WHERE b.time - a.time > 6 AND open <= a.time and close >= b.time;
```

