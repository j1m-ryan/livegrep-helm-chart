{{/*
Expand the name of the chart.
*/}}
{{- define "livegrep.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "livegrep.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "livegrep.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "livegrep.labels" -}}
helm.sh/chart: {{ include "livegrep.chart" . }}
{{ include "livegrep.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "livegrep.selectorLabels" -}}
app.kubernetes.io/name: {{ include "livegrep.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "livegrep.backendName" -}}
{{- printf "%s-backend" (include "livegrep.fullname" .) }}
{{- end }}

{{- define "livegrep.frontendName" -}}
{{- printf "%s-frontend" (include "livegrep.fullname" .) }}
{{- end }}

{{- define "livegrep.jobName" -}}
{{- printf "%s-fetch-repo" (include "livegrep.fullname" .) }}
{{- end }}
