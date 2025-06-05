#!/bin/bash

home="/afs/cern.ch/user/s/shuangyu/"
eventsnum=1000
cd ${home}"CMSSW_10_6_28_patch1"
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd -
cmsRun gen.py chunknum=$1 maxEvents=${eventsnum}

cd ${home}"CMSSW_10_6_17_patch1"
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd -
cmsRun sim.py chunknum=$1 maxEvents=${eventsnum}
cmsRun digi2raw.py chunknum=$1 maxEvents=${eventsnum}

cd ${home}"CMSSW_9_4_14_UL_patch1"
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd -
cmsRun hlt.py chunknum=$1 maxEvents=${eventsnum}

cd ${home}"CMSSW_10_6_17_patch1"
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd -
cmsRun reco.py chunknum=$1 maxEvents=${eventsnum}

cd ${home}"CMSSW_10_6_20"
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd -
cmsRun pat.py chunknum=$1 maxEvents=${eventsnum}
