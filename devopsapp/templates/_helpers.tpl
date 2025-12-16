{{/*
Expand the name of the chart.
*/}}
{{- define "bdapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bdapp.fullname" -}}
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
{{- define "bdapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bdapp.labels" -}}
helm.sh/chart: {{ include "bdapp.chart" . }}
{{ include "bdapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bdapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bdapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bdapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bdapp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Host address of destination service
*/}}
{{- define "bdapp.destination-host" -}}
{{- $context := index . 0 -}}
{{- $path    := index . 1 -}}
{{- if $path.host -}}
{{ $path.host }}
{{- else -}}
{{ include "bdapp.fullname" $context }}.{{ $context.Release.Namespace }}.svc.cluster.local
{{- end -}}
{{- end -}}

{{/*
Create persistentVolume
*/}}
{{- define "bdapp.persistentVolumeEnabled" -}}
{{- .Values.persistentVolume.enabled | default false -}}
{{- end }}