{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "metfrag.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "metfrag.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "metfrag.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "metfrag.labels" -}}
helm.sh/chart: {{ include "metfrag.chart" . }}
{{- if .Values.k8sTicket.enabled }}
ipb-halle.de/k8sticket: "true"
{{- end }}
{{ include "metfrag.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- define "metfrag.annotations" -}}
{{- if .Values.k8sTicket.enabled }}
ipb-halle.de/k8sticket.deployment.app.name: {{ trimAll "/" .Values.webpath }}
ipb-halle.de/k8sticket.ingress.dns: "true"
{{- end }}
{{- end -}}
{{- define "metfrag.pod.template.annotations" -}}
{{- if .Values.k8sTicket.enabled }}
ipb-halle.de/k8sticket.pod.path: {{ trimAll "/" .Values.webpath }}
ipb-halle.de/k8sticket.pod.port: "8080"
{{- end }}
{{- end -}}
{{- define "metfrag.pod.template.labels" -}}
{{- if .Values.k8sTicket.enabled }}
ipb-halle.de/k8sticket.deployment.app.name: {{ trimAll "/" .Values.webpath }}
{{- end }}
{{- end -}}

{{- define "k8sticket.labels" -}}
helm.sh/chart: {{ include "metfrag.chart" . }}
{{ include "k8sticket.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "metfrag.selectorLabels" -}}
app.kubernetes.io/name: {{ include "metfrag.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "k8sticket.selectorLabels" -}}
app.kubernetes.io/name: "k8sticket"
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "metfrag.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "metfrag.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
