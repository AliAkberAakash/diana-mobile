import 'package:diana/data/remote_models/subtask/subtask_result.dart';
import 'package:diana/data/remote_models/task/task_result.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'package:diana/data/database/models/subtask/subtask_dao.dart';
import 'package:diana/data/database/models/tag/tag_dao.dart';
import 'package:diana/data/database/models/task/task_dao.dart';
import 'package:diana/data/database/relations/task_with_subtasks/task_with_subtasks.dart';
import 'package:diana/data/remote_models/subtask/subtask_response.dart';
import 'package:diana/data/remote_models/tag/tag_response.dart';
import 'package:diana/data/remote_models/task/task_response.dart';
import 'package:diana/data/remote_models/tag/tag_result.dart';

abstract class TaskLocalSource {
  Future<void> deleteAndinsertTasks(
    TaskResponse taskResponse,
  );

  Future<void> insertTasks(TaskResponse taskResponse);

  Future<Stream<List<TaskWithSubtasks>>> watchTodayTasks(String userId);

  Future<Stream<List<TaskWithSubtasks>>> watchAllTasks(String userId);

  Future<Stream<List<TaskWithSubtasks>>> watchCompletedTasks(String userId);

  Future<Stream<List<TaskWithSubtasks>>> watchMissedTasks(String userId);

  Future<int> deleteTag(String tagId);

  Future<int> insertTag(TagResult tagResult);

  Future<int> deleteTask(String taskId);

  Future<int> insertTask(TaskResult taskResult);

  Future<int> deleteSubTask(String subtaskId);

  Future<int> insertSubTask(SubtaskResult subtaskResult);

  Future<void> deleteAndInsertSubTasks(SubtaskResponse subtaskResponse);

  Future<void> insertSubTasks(SubtaskResponse subtaskResponse);

  Future<void> deleteAndInsertTags(TagResponse tagResponse);

  Future<void> insertTags(TagResponse tagResponse);
}

class TaskLocalSourceImpl extends TaskLocalSource {
  final TaskDao taskDao;
  final TagDao tagDao;
  final SubTaskDao subTaskDao;

  TaskLocalSourceImpl({
    this.taskDao,
    this.tagDao,
    this.subTaskDao,
  });

  @override
  Future<void> deleteAndinsertTasks(
    TaskResponse taskResponse,
  ) {
    try {
      return taskDao.deleteAndinsertTasks(taskResponse);
    } on InvalidDataException {
      rethrow;
    }
  }

  @override
  Future<void> insertTasks(TaskResponse taskResponse) {
    try {
      return taskDao.insertTasks(taskResponse);
    } on InvalidDataException {
      rethrow;
    }
  }

  @override
  Future<Stream<List<TaskWithSubtasks>>> watchAllTasks(String userId) {
    return taskDao.watchAllTasks(userId);
  }

  @override
  Future<Stream<List<TaskWithSubtasks>>> watchCompletedTasks(String userId) {
    return taskDao.watchCompletedTasks(userId);
  }

  @override
  Future<Stream<List<TaskWithSubtasks>>> watchMissedTasks(String userId) {
    return taskDao.watchMissedTasks(userId);
  }

  @override
  Future<Stream<List<TaskWithSubtasks>>> watchTodayTasks(String userId) {
    return taskDao.watchTodayTasks(userId);
  }

  @override
  Future<int> deleteTag(String tagId) {
    return tagDao.deleteTag(tagId);
  }

  @override
  Future<int> insertTag(TagResult tagResult) {
    try {
      return tagDao.insertTag(tagResult);
    } on InvalidDataException {
      rethrow;
    }
  }

  @override
  Future<int> deleteTask(String taskId) {
    return taskDao.deleteTask(taskId);
  }

  @override
  Future<int> insertTask(TaskResult taskResult) {
    return taskDao.insertTask(taskResult);
  }

  @override
  Future<int> deleteSubTask(String subtaskId) {
    return subTaskDao.deleteSubTask(subtaskId);
  }

  @override
  Future<int> insertSubTask(SubtaskResult subtaskResult) {
    return subTaskDao.insertSubTask(subtaskResult);
  }

  @override
  Future<void> deleteAndInsertSubTasks(SubtaskResponse subtaskResponse) {
    try {
      return subTaskDao.deleteAndinsertSubTasks(subtaskResponse);
    } on InvalidDataException {
      rethrow;
    }
  }

  @override
  Future<void> insertSubTasks(SubtaskResponse subtaskResponse) {
    try {
      return subTaskDao.insertSubTasks(subtaskResponse);
    } on InvalidDataException {
      rethrow;
    }
  }

  @override
  Future<void> deleteAndInsertTags(TagResponse tagResponse) {
    try {
      return tagDao.deleteAndinsertTags(tagResponse);
    } on InvalidDataException {
      rethrow;
    }
  }

  @override
  Future<void> insertTags(TagResponse tagResponse) {
    try {
      return tagDao.insertTags(tagResponse);
    } on InvalidDataException {
      rethrow;
    }
  }
}
