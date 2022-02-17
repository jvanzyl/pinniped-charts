 {{/*
Expand the name of the chart.
*/}}
{{- define "@NAME@.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "@NAME@.fullname" -}}
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
{{- define "@NAME@.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "@NAME@.labels" -}}
helm.sh/chart: {{ include "@NAME@.chart" . }}
{{ include "@NAME@.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "@NAME@.selectorLabels" -}}
app.kubernetes.io/name: {{ include "@NAME@.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "@NAME@.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "@NAME@.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the image path for the passed in image field:
https://blog.andyserver.com/2021/09/adding-image-digest-references-to-your-helm-charts/
*/}}
{{- define "image" -}}
{{- if eq (substr 0 7 .version) "sha256:" -}}
{{- printf "%s/%s@%s" .registry .repository .version -}}
{{- else -}}
{{- printf "%s/%s:%s" .registry .repository .version -}}
{{- end -}}
{{- end -}}

{{/*
https://helm.sh/docs/howto/charts_tips_and_tricks/#creating-image-pull-secrets
*/}}
{{- define "imagePullSecret" }}
{{- with .Values.image }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .credentials.username .credentials.password .credentials.email (printf "%s:%s" .credentials.username .credentials.password | b64enc) | b64enc }}
{{- end }}
{{- end }}

{{/*
 Labels taking into account custom labels
*/}}
{{- define "labels" -}}
app: @NAME@
{{- with .customLabels }}
{{ toYaml . | indent 8 }}
{{- end }}
{{- end }}
