# Heap dump

```bash
path/to/jdk/jmap -dump:format=b,file=<filename> id_proces
```

# Heap summary

```bash
path/to/jdk/jmap -heap id_proces >> path/to/save_file/heap_summary_ddmmyy_hhmm.log
```

# Heap histogram

```bash
path/to/jdk/jmap -histo id_proces >> path/to/save_file/heap_histo_ddmmyy_hhmm.log
```

# Thread dump 

```bash  
path/to/jdk/jstack -F id_proces >> path/to/save_file/thread_dump_ddmmyy_hhmm.log
```

# Uptime (in seconds)
```bash
path/to/jdk/jcmd id_proces VM.uptime  
```

# VM Flags

```bash  
path/to/jdk/jcmd id_proces VM.flags    
```

# Invoke GC

```bash
path/to/jdk/jcmd id_proces GC.run   
```

# JVM Uptime (linux)
```bash  
ps -p <pid> -o stime,etime    
```
  
# Parse a heap dump with `jhat`
```bash
#obtain the heap dump
jmap -dump:format=b,file=heap.bin <jvm_process_id>

#parse the file
jhat heap.bin

#Reading from heap.bin...
#Dump file created Tue Sep 30 19:46:23 BST 2008
#Snapshot read, resolving...
#Resolving 35484 objects...
#Chasing references, expect 7 dots.......
#Eliminating duplicate references.......
#Snapshot resolved.
#Started HTTP server on port 7000
#Server is ready
```




Tools info 
==============

  * [Troubleshooting Guide - Oracle Docs](https://docs.oracle.com/javase/10/troubleshoot/JSTGD.pdf)

  * [The `jcmd` Utility](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/tooldescr006.html)

  * [Java Virtual Machine Statistics Monitoring Tool](https://docs.oracle.com/javase/7/docs/technotes/tools/share/jstat.html)
  
  * [The `jmap` Utility](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/tooldescr014.html)
  
  * [The `jstack` Utility](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/tooldescr016.html)
  
  * [The `jinfo` Utility](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/tooldescr013.html)
  
  * [The `hprof` Utility](https://docs.oracle.com/javase/8/docs/technotes/samples/hprof.html) and [more](http://www.brendangregg.com/blog/2014-06-09/java-cpu-sampling-using-hprof.html
)
  
Internet Stuff 
==============

  * [JIT explained](https://plumbr.io/blog/java/do-you-get-just-in-time-compilation)

  * [Java Heap Size 5 tips](https://dzone.com/articles/5-tips-proper-java-heap-size)  

  * [Eclipse Memory Analyzer (MAT) - Tutorial](https://www.vogella.com/tutorials/EclipseMemoryAnalyzer/article.html)
  
  * [Garbage Collector guidelines and tips](https://www.javacodegeeks.com/2013/12/garbage-collector-guidelines-and-tips.html)    
  
  * [Java Garbage Collection Distilled](https://www.infoq.com/articles/Java_Garbage_Collection_Distilled/)      
  
  * [Interning of String](https://www.geeksforgeeks.org/interning-of-string/)        
  
  * [Under the JVM hood – Classloaders](https://www.javacodegeeks.com/2012/12/under-the-jvm-hood-classloaders.html)
  
  * [Weak, Weaker, Weakest, Harnessing The Garbage Collector With Specialist References](https://www.javacodegeeks.com/2012/12/weak-weaker-weakest-harnessing-the-garbage-collector-with-specialist-references.html)        
