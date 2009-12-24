"""Helpers for executing a command in a subprocess (or subshell).
Supports writing a string to stdin and reading the stderr and stdout.
Also can throw an exception in case of status != 0"""
#(Tomas Gavenciak 2009)

import sys, os

class RuncmdException(Exception):
  def __init__(self, out=None, err=None, status=None, command=None):
    self.out = out
    self.err = err
    self.status = status
    self.command = command
  def __str__(self):
    return "Command: %s  Status: %s\n ---------- Stdout:\n%s\n ---------- Stderr:\n%s\n"%(self.command, self.status, self.out, self.err)
  pass

def runcmd3(cmd, args, intext="", chdir=None):
  """Run a command in a subshell, write intext to stdin.
  `cmd` is searched for in $PATH and args[0] is used as the name of the file.
  Child process cd's to chdir first if set.
  Return (stdout, stderr, status) -- the first two as strings"""
  (stdinr, stdinw) = os.pipe()
  (stdoutr, stdoutw) = os.pipe()
  (stderrr, stderrw) = os.pipe()
  pid = os.fork()
  if not pid:
    # Child process
    try:
      for fd in [stdinw, stderrr, stdoutr]:
        os.close(fd)
      os.dup2(stdinr, 0)
      os.dup2(stdoutw, 1)
      os.dup2(stderrw, 2)
      if chdir:
	os.chdir(chdir)
      os.execvp(cmd, args)
    except:
      sys.exit(42)
  # Parent process
  for fd in [stdinr, stderrw, stdoutw]:
    os.close(fd)
  pos = 0
  try:
    while (pos<len(intext)):
      pos += os.write(stdinw, intext)
  except:
    # Ignore all write errors
    pass
  os.close(stdinw)
  stat = os.waitpid(pid, 0)[1]
  fout = os.fdopen(stdoutr)
  ferr = os.fdopen(stderrr)
  # Wonder: do these two descriptors get closed?
  return (fout.read(), ferr.read(), stat)

def runshell3(command, intext="", shell='/bin/bash', shellargs=['-c'], **kwargs):
  """Wrapper to run the `command` in `shell` using runcmd3().
  Return the same as runcmd3()"""
  args = [shell] + shellargs + [command]
  return runcmd3(shell, args, **kwargs)


def runcmd3e(cmd, args=[], **kwargs):
  """Exec `cmd` using runcmd3(), raise a RuncmdException if status != 0.
  The exception contains the result of runcmd3().
  Returns the same as runcmd3() if status == 0."""
  (out, err, s) = runcmd3(cmd, args, **kwargs)
  if s:
    raise RuncmdException(out=out, err=err, status=s, command=cmd+' '+str(args))
  return (out, err, s)

def runshell3e(command, shell='/bin/bash', shellargs=['-c'], **kwargs):
  """Wrapper to run the `command` in `shell` using runcmd3e().
  Returns the same as runcmd3e() and runcmd3()"""
  args = [shell] + shellargs + [command]
  return runcmd3e(shell, args, **kwargs)


