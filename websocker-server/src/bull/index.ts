import Queue  from "bull";

const gameQueue: Queue.Queue = new Queue('default', 'redis://127.0.0.1:6379/0');

gameQueue.client.lrange("queue:default", 0, 1).then(x => console.log(x))

gameQueue.process((job: Queue.Job) => {
    console.log(job.data, "====")
})
