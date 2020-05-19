-- 表字段注释  https://blog.csdn.net/sqlgao22/article/details/100697214
-- 存储与已触发的 Trigger 相关的状态信息，以及相联 Job 的执行信息
drop table if exists duke_qrtz_fired_triggers;
-- 存储已暂停的 Trigger 组的信息
drop table if exists duke_qrtz_paused_trigger_grps;
-- 存储集群中note实例信息，quartz会定时读取该表的信息判断集群中每个实例的当前状态。
drop table if exists duke_qrtz_scheduler_state;
-- 存储程序的悲观锁的信息(假如使用了悲观锁)。
drop table if exists duke_qrtz_locks;
-- 存储简单的 Trigger，包括重复次数，间隔，以及已触发的次数。
drop table if exists duke_qrtz_simple_triggers;
-- 存储CalendarIntervalTrigger和DailyTimeIntervalTrigger
drop table if exists duke_qrtz_simprop_triggers;
-- 存储触发器的cron表达式表
drop table if exists duke_qrtz_cron_triggers;
-- Trigger 作为 Blob 类型存储(用于 Quartz 用户用 JDBC 创建他们自己定制的 Trigger 类型，JobStore 并不知道如何存储实例的时候)
drop table if exists duke_qrtz_blob_triggers;
-- 保存触发器的基本信息
drop table if exists duke_qrtz_triggers;
-- 存储每一个已配置的 jobDetail 的详细信息
drop table if exists duke_qrtz_job_details;
-- 以 Blob 类型存储存放日历信息， quartz可配置一个日历来指定一个时间范围
drop table if exists duke_qrtz_calendars;


create table duke_qrtz_job_details
(
    sched_name        varchar(120) not null,
    job_name          varchar(200) not null,
    job_group         varchar(200) not null,
    description       varchar(250) null,
    job_class_name    varchar(250) not null,
    is_durable        varchar(1)   not null,
    is_nonconcurrent  varchar(1)   not null,
    is_update_data    varchar(1)   not null,
    requests_recovery varchar(1)   not null,
    job_data          blob         null,
    primary key (sched_name, job_name, job_group)
);

create table duke_qrtz_triggers
(
    sched_name     varchar(120) not null,
    trigger_name   varchar(200) not null,
    trigger_group  varchar(200) not null,
    job_name       varchar(200) not null,
    job_group      varchar(200) not null,
    description    varchar(250) null,
    next_fire_time bigint(13)   null,
    prev_fire_time bigint(13)   null,
    priority       integer      null,
    trigger_state  varchar(16)  not null,
    trigger_type   varchar(8)   not null,
    start_time     bigint(13)   not null,
    end_time       bigint(13)   null,
    calendar_name  varchar(200) null,
    misfire_instr  smallint(2)  null,
    job_data       blob         null,
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, job_name, job_group)
        references duke_qrtz_job_details (sched_name, job_name, job_group)
);

create table duke_qrtz_simple_triggers
(
    sched_name      varchar(120) not null,
    trigger_name    varchar(200) not null,
    trigger_group   varchar(200) not null,
    repeat_count    bigint(7)    not null,
    repeat_interval bigint(12)   not null,
    times_triggered bigint(10)   not null,
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, trigger_name, trigger_group)
        references duke_qrtz_triggers (sched_name, trigger_name, trigger_group)
);

create table duke_qrtz_cron_triggers
(
    sched_name      varchar(120) not null,
    trigger_name    varchar(200) not null,
    trigger_group   varchar(200) not null,
    cron_expression varchar(200) not null,
    time_zone_id    varchar(80),
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, trigger_name, trigger_group)
        references duke_qrtz_triggers (sched_name, trigger_name, trigger_group)
);

create table duke_qrtz_simprop_triggers
(
    sched_name    varchar(120)   not null,
    trigger_name  varchar(200)   not null,
    trigger_group varchar(200)   not null,
    str_prop_1    varchar(512)   null,
    str_prop_2    varchar(512)   null,
    str_prop_3    varchar(512)   null,
    int_prop_1    int            null,
    int_prop_2    int            null,
    long_prop_1   bigint         null,
    long_prop_2   bigint         null,
    dec_prop_1    numeric(13, 4) null,
    dec_prop_2    numeric(13, 4) null,
    bool_prop_1   varchar(1)     null,
    bool_prop_2   varchar(1)     null,
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, trigger_name, trigger_group)
        references duke_qrtz_triggers (sched_name, trigger_name, trigger_group)
);

create table duke_qrtz_blob_triggers
(
    sched_name    varchar(120) not null,
    trigger_name  varchar(200) not null,
    trigger_group varchar(200) not null,
    blob_data     blob         null,
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, trigger_name, trigger_group)
        references duke_qrtz_triggers (sched_name, trigger_name, trigger_group)
);

create table duke_qrtz_calendars
(
    sched_name    varchar(120) not null,
    calendar_name varchar(200) not null,
    calendar      blob         not null,
    primary key (sched_name, calendar_name)
);

create table duke_qrtz_paused_trigger_grps
(
    sched_name    varchar(120) not null,
    trigger_group varchar(200) not null,
    primary key (sched_name, trigger_group)
);

create table duke_qrtz_fired_triggers
(
    sched_name        varchar(120) not null,
    entry_id          varchar(95)  not null,
    trigger_name      varchar(200) not null,
    trigger_group     varchar(200) not null,
    instance_name     varchar(200) not null,
    fired_time        bigint(13)   not null,
    sched_time        bigint(13)   not null,
    priority          integer      not null,
    state             varchar(16)  not null,
    job_name          varchar(200) null,
    job_group         varchar(200) null,
    is_nonconcurrent  varchar(1)   null,
    requests_recovery varchar(1)   null,
    primary key (sched_name, entry_id)
);

create table duke_qrtz_scheduler_state
(
    sched_name        varchar(120) not null,
    instance_name     varchar(200) not null,
    last_checkin_time bigint(13)   not null,
    checkin_interval  bigint(13)   not null,
    primary key (sched_name, instance_name)
);

create table duke_qrtz_locks
(
    sched_name varchar(120) not null,
    lock_name  varchar(40)  not null,
    primary key (sched_name, lock_name)
);
