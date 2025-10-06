const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: "postgres",
  host: "db", // same name as in docker-compose service
  database: "mydb",
  password: "postgres",
  port: 5432,
});

app.get("/", (req, res) => {
  res.send("Backend connected to PostgreSQL!");
});

app.listen(3001, () => console.log("Backend running on port 3001"));
