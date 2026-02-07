const db = require('../config/database');

exports.getAllCourses = () => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM classes', (err, results) => {
      if (err) reject(err);
      resolve(results);
    });
  });
};

exports.getCourseById = async (id) => {
  const result = await db.query(
    'SELECT * FROM classes WHERE id = $1',
    [id]
  );
  return result.rows[0] || null;
};


exports.createCourse = async (data) => {
  const {
    tutor_id,
    title,
    price,
    description,
    category_id,
    level
  } = data;

  const result = await db.query(
    `INSERT INTO classes
     (tutor_id, title, price, description, category_id, level)
     VALUES ($1, $2, $3, $4, $5, $6)
     RETURNING *`,
    [tutor_id, title, price, description, category_id, level]
  );

  return result.rows[0];
};


exports.updateCourse = async (id, data) => {
  const { title, price, description } = data;

  const result = await db.query(
    `UPDATE classes
     SET title = $1,
         price = $2,
         description = $3
     WHERE id = $4
     RETURNING *`,
    [title, price, description, id]
  );

  return result.rows[0] || null;
};


exports.deleteCourse = async (id) => {
  const result = await db.query(
    'DELETE FROM classes WHERE id = $1 RETURNING *',
    [id]
  );

  return result.rows[0] || null;
};
