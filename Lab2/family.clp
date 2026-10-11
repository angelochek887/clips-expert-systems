(deftemplate relative
 (slot relation (allowed-values father mother parents))
 (slot of)
 (multislot is))

(deftemplate family-role
 (slot name)
 (slot role (allowed-values father mother son daughter)))

(deftemplate gender
 (slot name)
 (slot sex (allowed-values male female)))

(deffacts family
 (relative (relation father) (of John) (is Tom))
 (relative (relation mother) (of John) (is Susan))
 (relative (relation parents) (of John) (is Tom Susan))
 (family-role (name Tom) (role father))
 (family-role (name Susan) (role mother))
 (family-role (name John) (role son))
 (gender (name Tom) (sex male))
 (gender (name Susan) (sex female))
 (gender (name John) (sex male)))