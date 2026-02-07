const service = require('../services/course.service');

exports.getAll = async (req, res) => {
  try {
    const data = await service.getAllCourses();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


exports.getById = async (req, res) => {
  const data = await service.getCourseById(req.params.id);

  if (!data) {
    return res.status(404).json({
      message: 'Course tidak ditemukan'
    });
  }

  res.json(data);
};


exports.create = async (req, res) => {
  const data = req.body;

  if (!data || Object.keys(data).length === 0) {
    return res.status(400).json({
      message: 'Payload tidak boleh kosong'
    });
  }

  const result = await service.createCourse(data);

  res.status(201).json({
    message: 'Course berhasil dibuat',
    data: result
  });
};

exports.update = async (req, res) => {
  const id = req.params.id;
  const data = req.body;

  console.log('PARAM ID:', id);
  console.log('BODY:', data);

  if (!data || Object.keys(data).length === 0) {
    return res.status(400).json({
      message: 'Payload tidak boleh kosong'
    });
  }

  const result = await service.updateCourse(id, data);

  if (!result) {
    return res.status(404).json({ message: 'Course tidak ditemukan' });
  }

  res.json({
    message: 'Course updated',
    data: result
  });
};

exports.remove = async (req, res) => {
  await service.deleteCourse(req.params.id);
  res.json({ message: 'Course deleted' });
};
