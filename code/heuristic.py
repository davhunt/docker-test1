
import os

def create_key(template, outtype=('nii.gz',), annotation_classes=None):

    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    
    return template, outtype, annotation_classes

def infotodict(seqinfo):
    """Heuristic evaluator for determining which runs belong where
    allowed template fields - follow python string module:
    item: index within category
    subject: participant id
    session: ses-<session id>
    seqitem: run number during scanning
    subindex: sub index within group
    """
    
    t1w = create_key('sub-{subject}/{session}/anat/sub-{subject}_{session}_T1w')
    dwi = create_key('sub-{subject}/{session}/dwi/sub-{subject}_{session}_dwi')
    rs = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_bold')

    info = {t1w: [],dwi: [],rs: []}
    
    for idx, s in enumerate(seqinfo):
        if ('*tfl3d1_16ns' in s.sequence_name):
            info[t1w].append(s.series_id)
        if (('*ep_b0' in s.sequence_name) or ('ep_b0' in s.sequence_name)):
            info[dwi].append(s.series_id)
        if ('*epfid2d1_58' in s.sequence_name):
            info[rs].append(s.series_id)
       
    return info