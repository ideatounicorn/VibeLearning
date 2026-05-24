export type CarouselSlide = {
  type: string;
  title?: string;
  content?: string | string[];
  hierarchy?: { title: string; years: string; salary: string }[];
  tools?: string[];
};

export type RoadmapItem = {
  type: string;
  tag: string;
  emoji: string;
  title: string;
  description: string;
  why: string;
  isFree?: boolean;
};

export type RoleData = {
  id: string;
  color: string;
  pathSlug: string;
  carousel: CarouselSlide[];
  roadmapTitle?: string;
  roadmapSub?: string;
  emoji: string;
  label: string;
  goalTitle: string;
  roadmap: any[];
  phases?: {
    title: string;
    weeks: string;
    items: RoadmapItem[];
  }[];
};

export const ROLES: RoleData[] = [];
